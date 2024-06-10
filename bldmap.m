function error=bldmap
%    array size limits
     ixkms=1500;
     iykms=1500;
     izkms=1500;

      xl=bld-xn(1);
      ixmax=(xn(nx)+xl)/bld;
      yl=bld-yn(1);
      iymax=(yn(ny)+yl)/bld;
      zl=bld-zn(1);
      izmax=(zn(nz)+zl)/bld;

%  Check for array size overflow
      if(ixmax.gt.ixkms.or.iymax.gt.iykms.or.izmax.gt.izkms)
write(f16,' ***** error in array size maximum map dimensions (km) x=%d, y=%d z=%d',ixkms,iykms,izkms);
write(16,' Actual map size (km):  x=%d y=%d z=%d',ixmax,iymax,izmax);
      error=9999;
       return
      end
 
ix=1;
      for  i=1:ixmax
         ix1=ix+1;
         xnow=float(i)*bld-xl;
         if (xnow.ge.xn(ix1)) 
         ix=ix1;
         end
         ixloc(i)=ix;
       end
  
%  Fill remainder of array with zeroes.

      for  i=ixmax+1:ixkms
         ixloc(i)=0;
      end

 iy=1;
     for  i=1:iymax
         iy1=iy+1;
         ynow=float(i)*bld-yl;
         if (ynow.ge.yn(iy1))
             iy=iy1;
         end
         iyloc(i)=iy;
     end
      for i=iymax+1:iykms
         iyloc(i)=0;
      end
  iz=1;
      for  i=1:izmax
         iz1=iz+1;
         znow=float(i)*bld-zl;
         if (znow.ge.zn(iz1))
             iz=iz1;
         end
         izloc(i)=iz;
      end

     for i=izmax+1:izkms
         izloc(i)=0;
     end
     
 end
