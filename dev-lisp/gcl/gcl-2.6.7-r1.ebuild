# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gcl/gcl-2.6.7-r1.ebuild,v 1.8 2012/06/07 18:59:25 zmedico Exp $

inherit elisp-common eutils flag-o-matic autotools

DESCRIPTION="GNU Common Lisp"
HOMEPAGE="http://www.gnu.org/software/gcl/gcl.html"
SRC_URI="ftp://ftp.gnu.org/gnu/gcl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE="emacs readline debug X tk custreloc dlopen gprof doc ansi"

RDEPEND="emacs? ( virtual/emacs )
	readline? ( sys-libs/readline )
	>=dev-libs/gmp-4.1
	tk? ( dev-lang/tk )
	X? ( x11-libs/libXt x11-libs/libXext x11-libs/libXmu x11-libs/libXaw )"

DEPEND="$RDEPEND
	doc? ( virtual/texi2dvi )
	>=app-text/texi2html-1.64
	>=sys-devel/autoconf-2.52"

src_unpack() {
	unpack ${A}
	sed -e "s/gcl-doc/${PF}/g" "${S}"/info/makefile > "${T}"/makefile
	mv "${T}"/makefile "${S}"/info/makefile
	epatch "${FILESDIR}"/${PV}-fix-configure.in-gentoo.patch

	eautoconf || die
	epatch "${FILESDIR}"/flex-configure-LANG.patch # see Bug #122583
}

src_compile() {
	export SANDBOX_ON=0
	local myconfig=""

	# Hardened gcc may automatically use PIE building, which does not
	# work for this package so far

	filter-flags "-fPIC"

	# -fomit-frame-pointer cannot be used with gprof

	if use gprof; then
		filter-flags "-fomit-frame-pointer"
	fi

	# Unfortunately, we need to override any relocation choices below
	# while upstream doesn't work with system BFD.	SuSE has the same
	# problem apparently.

	if false; then

	# Linking options are enumerated at
	# http://www.gnu.org/software/gcl/RELEASE-2.6.2.html

	local dlopen_config="
		--disable-custreloc
		--enable-dlopen
		--disable-dynsysbfd
		--disable-statsysbfd";

	local bfd_config="
		--disable-custreloc
		--disable-dlopen
		--enable-dynsysbfd
		--disable-statsysbfd";

	local custreloc_config="
		--enable-custreloc
		--disable-dlopen
		--disable-dynsysbfd
		--disable-statsysbfd";

	if use custreloc; then
		case "${ARCH}" in
			x86 | sparc)
				myconfig="${myconfig} ${custreloc_config}";;
			*)
				ewarn "--enable-custreloc is not supported on your architecture (${ARCH})."
				ewarn "Using --enable-dlopen instead."
				myconfig="${myconfig} ${dlopen_config}"

		esac
	elif use dlopen; then
		myconfig="${myconfig} ${dlopen_config}"
	else
		case "${ARCH}" in
			x86 | sparc | ppc | amd64 | s390)
				myconfig="${myconfig} ${bfd_config}";;
			*)
				ewarn "BFD is not supported on your architecture (${ARCH})."
				ewarn "Using --enable-dlopen instead."
				myconfig="${myconfig} ${dlopen_config}";;
		esac
	fi

	else
		myconfig="${myconfig} --enable-locbfd --disable-dynsysbfd --disable-statsysbfd"
	fi

	if use tk; then
		myconfig="${myconfig}
		--enable-tkconfig=/usr/lib
		--enable-tclconfig=/usr/lib"
	fi

	myconfig="${myconfig}
		--enable-dynsysgmp
		`use_enable readline readline`
		`use_with X x`
		`use_enable debug debug`
		`use_enable gprof gprof`
		`use_enable ansi ansi`
		--enable-xdr=no
		--enable-infodir=/usr/share/info
		--enable-emacsdir=/usr/share/emacs/site-lisp/gcl"

	einfo "Configuring with the following:
${myconfig}"
	econf ${myconfig} || die
	make || die

	sed -e 's,@EXT@,,g' debian/in.gcl.1 >gcl.1
}

src_install() {
	export SANDBOX_ON=0
	make DESTDIR="${D}" install || die

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

	find "${D}"/usr/lib/gcl-${PV}/ -type f \( -perm 640 -o -perm 750 \) -exec chmod 0644 '{}' \;
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
