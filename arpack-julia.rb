require 'formula'

class ArpackJulia < Formula
  homepage 'http://forge.scilab.org/index.php/p/arpack-ng'
  url 'http://forge.scilab.org/index.php/p/arpack-ng/downloads/get/arpack-ng-3.1.3.tar.gz'
  mirror 'http://d304tytmzqn1fl.cloudfront.net/arpack-ng-3.1.3.tar.gz'
  sha1 'c1ac96663916a4e11618e9557636ba1bd1a7b556'

  depends_on :fortran
  depends_on :mpi => :f77
  depends_on 'openblas-julia' if build.without? 'accelerate'

  keg_only "Conflicts with arpack"

  option 'with-accelerate', 'Compile against Accelerate/vecLib instead of OpenBLAS'

  def install

    configure_args = ["--disable-dependency-tracking", "--prefix=#{prefix}", "--enable-shared"]
    if build.with? "accelerate"
      configure_args << "--with-blas=-framework vecLib -lblas"
      configure_args << "--with-lapack=-framework vecLib -lblas"
    else
      configure_args << "--with-blas=openblas"
      configure_args << "--with-lapack=openblas"
    end

    system "./configure", *configure_args

    system "make install"
  end
end
