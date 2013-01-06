# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/spidermonkey/spidermonkey-1.8.2.15.ebuild,v 1.3 2012/05/03 02:41:39 jdhore Exp $

EAPI="3"
inherit eutils toolchain-funcs multilib python

MY_PV="${PV}"
MY_PV="${MY_PV/1.8.2/3.6}"
DESCRIPTION="Stand-alone JavaScript C library"
HOMEPAGE="http://www.mozilla.org/js/spidermonkey/"
REL_URI="http://releases.mozilla.org/pub/mozilla.org/firefox/releases"
SRC_URI="${REL_URI}/${MY_PV}/source/firefox-${MY_PV}.source.tar.bz2"

LICENSE="NPL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ppc ppc64 sparc x86 ~x86-fbsd ~x64-macos ~x86-macos"
IUSE="threadsafe"

S="${WORKDIR}/mozilla-1.9.2"
BUILDDIR="${S}/js/src"

RDEPEND="threadsafe? ( >=dev-libs/nspr-4.8.6 )"

DEPEND="${RDEPEND}
	app-arch/zip
	=dev-lang/python-2*[threads]
	virtual/pkgconfig"

pkg_setup(){
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.9.2.13-as-needed.patch"

	epatch_user

	cd "${S}"
	if [[ ${CHOST} == *-freebsd* ]]; then
		# Don't try to be smart, this does not work in cross-compile anyway
		ln -s "${BUILDDIR}/config/Linux_All.mk" "${S}/config/$(uname -s)$(uname -r).mk"
	fi
}

src_configure() {
	cd ${BUILDDIR}

	local myconf

	if use threadsafe ; then
		myconf="${myconf} --with-system-nspr \
			--enable-threadsafe"
	fi
	# Disable no-print-directory
	MAKEOPTS=${MAKEOPTS/--no-print-directory/}

	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" PYTHON="$(PYTHON)" econf \
		${myconf}
}

src_compile() {
	cd ${BUILDDIR}
	emake -j1 || die "emake failed";
}

src_install() {
	cd ${BUILDDIR}
	emake install DESTDIR="${D}" || die
	dodoc ../jsd/README
	dohtml README.html

	if [[ ${CHOST} == *-darwin* ]] ; then
		# fixup install_name
		install_name_tool -id "${EPREFIX}"/usr/$(get_libdir)/libmozjs.dylib \
			"${ED}"/usr/$(get_libdir)/libmozjs.dylib || die
	fi
}
