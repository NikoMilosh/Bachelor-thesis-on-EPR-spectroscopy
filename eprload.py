#!/usr/bin/python3
# -*- coding: utf8 -*-

"""
eprload loads various EPR spectra formats
currently supported is the Bruker BES3t (DSC/DTA) format

author: Christian Teutloff

created: 17.01.2019
modified: 28.01.2019

usage:
axis,spec,pars=eprload(file);
axis) x-(and if existing y-) axis
spec) 1- or 2-D intensity data
    if complex data, then in complex format,
    if more than 1 channnel, 1 list per channel is returned,
    if 2-D data, a list of lists is returned, where each sublist contains 1 row of data
pars) parameters of the experiment as a dictionary

"""

import struct

def eprload(file):
    # tries to load data from file
    # supported formats: DSC/DTA (Bruker)

    fname,extension = file.split('.')
    if extension == 'DSC' or extension == 'DTA':
        pars={}
        ## parameters from descriptor
        with open(fname+'.DSC','r') as f:
            lines=[line.rstrip('\n') for line in f]
            ## now import keywords into dict, create axes, parameter strings

        for line in lines:
            if line[0:4]=='#SPL':
                break
            else:
                if line[0]!='*':
                    par_pairs=(line.replace('\'','').strip('#').split('\t'))
                    pars.update({par_pairs[0]:par_pairs[1]})
                else:
                    continue
        
        # data

        with open(fname+'.DTA','rb') as f:
            data_raw=f.read()
            ## now unpack data into double format

        if pars['IRFMT']=='D' or pars['IRFMT']=='D,D': # 8-byte (double) data
            b_offset = 8

        data_unpacked=[struct.unpack('>d',data_raw[i:i+b_offset])[0] for i in range(0,len(data_raw),b_offset)]
        print('Länge entpackte Daten: %i\n' % len(data_unpacked))
        print('pars.XPTS: %s\n' % pars['XPTS'])
        ## distinguish between different data types
        if pars['YTYP'] == 'NODATA':
            # 1D axis
            axis = [float(pars['XMIN'])+ float(pars['XWID'])/float(pars['XPTS'])*i for i in range(0,int(pars['XPTS']))]

            # 1D data
            if pars['IKKF'] == 'CPLX':
                # 1D complex data
                real=[data_unpacked[i*2] for i in range(0,int(pars['XPTS']))] # len(data_raw)/2)
                imag=[data_unpacked[i*2+1] for i in range(0,int(pars['XPTS']))]
                data=[complex(real[x],imag[x]) for x in range(0,len(real))]
            elif pars['IKKF'] == 'REAL':
                # 1D real data (cw)
                data = data_unpacked
            elif pars['IKKF'] == 'REAL,REAL':
                # 1D, 2-channel real data 
                data0 = [data_unpacked[i*2] for i in range(0,int(pars['XPTS']))]
                data1 = [data_unpacked[i*2+1] for i in range(0,int(pars['XPTS']))]
                data = [data0,data1]
        elif pars['YTYP'] == 'IDX':
            # 2D axis
            axis=[[],[]]
            axis[0] = [float(pars['XMIN'])+ float(pars['XWID'])/float(pars['XPTS'])*i for i in range(0,int(pars['XPTS']))]
            axis[1] = [float(pars['YMIN'])+ float(pars['YWID'])/float(pars['YPTS'])*i for i in range(0,int(pars['YPTS']))]
            # 2D data
            if pars['IKKF'] == 'CPLX':
                # 2D complex data
                xlen=int(pars['XPTS'])
                ylen=int(pars['YPTS'])
                real=[]
                imag=[]
                data=[]
                for j in range(0,ylen):
                    real.append([data_unpacked[2*xlen*j+i*2] for i in range(0,xlen)])
                    imag.append([data_unpacked[(2*xlen*j)+i*2+1] for i in range(0,xlen)])
                data.append([[complex(real[y][x],imag[y][x]) for x in range(0,xlen)] for y in range(0,ylen)])
        
        return axis,data,pars

