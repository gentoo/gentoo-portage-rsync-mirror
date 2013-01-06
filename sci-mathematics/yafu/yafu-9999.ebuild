# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/yafu/yafu-9999.ebuild,v 1.2 2013/01/06 15:39:41 patrick Exp $

EAPI=4
DESCRIPTION="Yet another factoring utility"
HOMEPAGE="http://sourceforge.net/projects/yafu/"
#SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}-src.zip"
ESVN_REPO_URI="https://yafu.svn.sourceforge.net/svnroot/yafu"

inherit eutils subversion

LICENSE="public-domain"
SLOT="0"
KEYWORDS=""
# nfs is overloaded, so using less confusing sieve here
IUSE="+sieve"

DEPEND="dev-libs/gmp
	sci-mathematics/gmp-ecm
	sieve? ( sci-mathematics/msieve
		sci-mathematics/ggnfs )"
RDEPEND="${DEPEND}"

src_prepare() {
	cd trunk
	# This is not nice. But then the Makefile is quite special :)
	sed -i -e 's:../gmp/include:gmp:' Makefile 		|| die "Failed to rectify things"
	sed -i -e 's:../gmp-ecm/include:gmp-ecm:' Makefile 	|| die "Failed to rectify things"
	sed -i -e 's:LIBS += -L../:# LIBS += -L../:g' Makefile	|| die "Failed to rectify things"
	sed -i -e 's:\"config.h\":<gmp-ecm/config.h>:g' top/driver.c	|| die "Failed to rectify things"
	sed -i -e 's:# LIBS += -L../msieve/lib/linux/x86_64:LIBS += -lmsieve -lz -ldl:' Makefile	|| die "Failed to rectify things"
	sed -i -e 's:CFLAGS = -g:#CFLAGS = -g:' Makefile	|| die "Failed to rectify things"

	# proper ggnfs default path
	sed -i -e 's~strcpy(fobj->nfs_obj.ggnfs_dir,"./");~strcpy(fobj->nfs_obj.ggnfs_dir,"/usr/bin/");~' factor/factor_common.c || die "Failed to rectify things"
}

src_compile() {
	cd trunk
	# hmm, not that useful:
	#VAR="TIMING=1 "
	if use sieve; then
		VAR+="NFS=1"
	fi
	if use amd64; then
		emake $VAR x86_64 || die "Failed to build"
	fi
	if use x86; then
		emake $VAR x86 || die "Failed to build"
	fi
}

src_install() {
	mkdir -p "${D}/usr/bin/"
	cp "${S}/trunk/yafu" "${D}/usr/bin/" 					|| die "Failed to install"
	mkdir -p "${D}/usr/share/doc/${PN}"
	cp "${S}/trunk/docfile.txt" "${D}/usr/share/doc/${PN}/yafu.txt" 	|| die "Failed to install"
	cp "${S}/trunk/README" "${D}/usr/share/doc/${PN}/"			|| die "Failed to install"
	cp "${S}/trunk/yafu.ini" "${D}/usr/share/doc/${PN}/yafu.ini.example"	|| die "Failed to install"
}
