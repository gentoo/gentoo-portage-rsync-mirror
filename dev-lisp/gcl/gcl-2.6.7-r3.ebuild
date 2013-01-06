# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gcl/gcl-2.6.7-r3.ebuild,v 1.6 2012/06/07 18:59:25 zmedico Exp $

#removing flag-o-matic results in make install failing due to a segfault
inherit elisp-common eutils flag-o-matic

DEB_PV=34

DESCRIPTION="GNU Common Lisp"
HOMEPAGE="http://www.gnu.org/software/gcl/gcl.html"
SRC_URI="mirror://debian/pool/main/g/gcl/gcl_${PV}.orig.tar.gz
	mirror://debian/pool/main/g/gcl/gcl_${PV}-${DEB_PV}.diff.gz
	mirror://gnu/gcl/${PN}.info.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc ~x86"
IUSE="emacs readline debug X tk doc ansi"

RDEPEND="emacs? ( virtual/emacs )
	readline? ( sys-libs/readline )
	>=dev-libs/gmp-4.1
	tk? ( dev-lang/tk )
	X? ( x11-libs/libXt x11-libs/libXext x11-libs/libXmu x11-libs/libXaw )
	virtual/latex-base"				# pdflatex (see Bug # 157903)
DEPEND="${RDEPEND}
	doc? ( virtual/texi2dvi )
	>=app-text/texi2html-1.64
	>=sys-devel/autoconf-2.52"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ../gcl_${PV}-${DEB_PV}.diff
	epatch "${FILESDIR}"/flex-configure-LANG.patch
	sed -ie "s/gcl-doc/${PF}/g" "${S}"/info/makefile
}

src_compile() {
#	export SANDBOX_ON=0
	local myconfig=""
	# Hardened gcc may automatically use PIE building, which does not
	# work for this package so far
#	filter-flags "-fPIC"
	if use tk; then
		myconfig="${myconfig} --enable-tkconfig=/usr/lib --enable-tclconfig=/usr/lib"
	fi
	myconfig="${myconfig}
		--enable-locbfd
		--disable-dynsysbfd
		--disable-statsysbfd
		--enable-dynsysgmp
		$(use_enable readline readline)
		$(use_with X x)
		$(use_enable debug debug)
		$(use_enable ansi ansi)
		--enable-xdr=no
		--enable-infodir=/usr/share/info
		--enable-emacsdir=/usr/share/emacs/site-lisp/gcl"
	einfo "Configuring with the following:
${myconfig}"
	econf ${myconfig}
	make || die "make failed"
	sed -e 's,@EXT@,,g' debian/in.gcl.1 >gcl.1
}

src_install() {
	# workaround for bug 161041, see bug 164656 for follow up
	export SANDBOX_ON=0
	make DESTDIR="${D}" install || die "make install failed"

	rm -rf "${D}"/usr/lib/${P}/info
	mv "${D}"/default.el elisp/

	if use emacs; then
		mv elisp/add-default.el "${T}"/50gcl-gentoo.el
		elisp-site-file-install "${T}"/50gcl-gentoo.el
		elisp-install ${PN} elisp/*
		fperms 0644 /usr/share/emacs/site-lisp/gcl/*
	else
		rm -rf "${D}"/usr/share/emacs
	fi

	dosed /usr/bin/gcl
	fperms 0755 /usr/bin/gcl

	# fix the GCL_TK_DIR=/var/tmp/portage/${P}/image//
	dosed /usr/lib/${P}/gcl-tk/gcltksrv
	fperms 0755 /usr/lib/${P}/gcl-tk/gcltksrv

	#repair gcl.exe symlink
	#rm ${D}/usr/bin/gcl.exe
	dosym ../lib/${P}/unixport/saved_gcl /usr/bin/gcl.exe

	dodoc readme* RELEASE* ChangeLog* doc/*

	for i in "${D}"/usr/share/doc/gcl-{tk,si}; do
		mv $i "${D}"/usr/share/doc/${PF}
	done

	doman gcl.1
	doinfo info/*.info*

	find "${D}"/usr/lib/gcl-${PV}/ -type f \( -perm 640 -o -perm 750 \) -exec chmod 0644 '{}' \;
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
