# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexftp/obexftp-0.23-r1.ebuild,v 1.13 2012/05/02 20:10:09 jdhore Exp $

EAPI="3"

WANT_AUTOMAKE=1.9

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils perl-module flag-o-matic autotools

DESCRIPTION="File transfer over OBEX for mobile phones"
HOMEPAGE="http://dev.zuckschwerdt.org/openobex/wiki/ObexFtp"
SRC_URI="mirror://sourceforge/openobex/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 hppa ppc ~sparc x86"
IUSE="bluetooth debug perl python ruby tcl"

RDEPEND="dev-libs/openobex
	bluetooth? ( net-wireless/bluez )
	perl? ( dev-lang/perl )
	ruby? ( dev-lang/ruby:1.8 )
	tcl? ( dev-lang/tcl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DISTUTILS_SETUP_FILES=("swig/python|setup.py")

pkg_setup() {
	use python && python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-fixruby.patch
	epatch "${FILESDIR}/${P}-gentoo.patch"

	# Python bindings are built/installed manually.
	sed -e "/MAYBE_PYTHON_ = python/d" -i swig/Makefile.am || die "sed failed"

	eautomake
}

src_configure() {
	if use debug ; then
		strip-flags
		append-flags "-g -DOBEXFTP_DEBUG=5"
	fi

	local MYRUBY
	use ruby && MYRUBY="RUBY=/usr/bin/ruby18"

	econf \
		$(use_enable bluetooth) \
		$(use_enable perl) \
		$(use_enable python) \
		$(use_enable tcl) \
		$(use_enable ruby) \
		${MYRUBY}
}

src_compile() {
	default

	use python && distutils_src_compile
}

src_install() {
	# -j1 because "make -fMakefile.ruby install" fails
	# upstream added -j1 to that command so it should be removed
	# from here in the next version bump
	emake -j1 DESTDIR="${D}" INSTALLDIRS=vendor install || die "emake install failed"

	use python && distutils_src_install

	dodoc AUTHORS ChangeLog NEWS README* THANKS TODO
	dohtml doc/*.html

	# Install examples
	insinto /usr/share/doc/${PF}/examples
	doins examples/*.c
	use perl && doins examples/*.pl
	use python && doins examples/*.py
	use ruby && doins examples/*.rb
	use tcl && doins examples/*.tcl

	if use perl ; then
		perl_delete_localpod
		perl_delete_packlist
	fi
}

pkg_postinst() {
	use perl && perl-module_pkg_postinst
	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use perl && perl-module_pkg_postrm
	use python && distutils_pkg_postrm
}
