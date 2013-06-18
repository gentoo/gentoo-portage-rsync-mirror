# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libdom/libdom-0.0.1.ebuild,v 1.1 2013/06/18 05:58:50 xmw Exp $

EAPI=5

inherit base toolchain-funcs multilib-minimal

DESCRIPTION="implementation of the W3C DOM, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libdom/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="expat test xml"

RDEPEND=">=dev-libs/libparserutils-0.1.2[static-libs?,${MULTILIB_USEDEP}]
	>=dev-libs/libwapcaplet-0.2.0[static-libs?,${MULTILIB_USEDEP}]
	>=net-libs/libhubbub-0.2.0[static-libs?,${MULTILIB_USEDEP}]
	xml? (
		expat? ( dev-libs/expat[static-libs?]
			amd64? ( abi_x86_32? ( app-emulation/emul-linux-x86-baselibs[development] ) ) )
		!expat? ( dev-libs/libxml2[static-libs?]
			amd64? ( abi_x86_32? ( app-emulation/emul-linux-x86-baselibs[development] ) ) )
	)"
DEPEND="${RDEPEND}
	test? ( dev-lang/perl
		dev-perl/XML-XPath
		dev-perl/libxml-perl
		perl-core/Switch )"

REQUIRED_USE="test? ( xml )"

### future context of netsurf.eclass

NETSURF_BUILDSYSTEM="${NETSURF_BUILDSYSTEM:-buildsystem-1.0}"
SRC_URI=${SRC_URI:-http://download.netsurf-browser.org/libs/releases/${P}-src.tar.gz}
SRC_URI+="
	http://download.netsurf-browser.org/libs/releases/${NETSURF_BUILDSYSTEM}.tar.gz -> netsurf-${NETSURF_BUILDSYSTEM}.tar.gz"
IUSE+=" debug static-libs"
if has doc ${IUSE} ; then
	DEPEND+="
	doc? ( app-doc/doxygen )"
fi
DEPEND+="
	virtual/pkgconfig"
pkg_setup(){
	netsurf_src_prepare() {
		if [ -f docs/doxygen.conf ] ; then
			if ! has doc ${IUSE} ; then
				if [ -z "${NETSURF_IGNORE_DOXYGEN}" ] ; then
					die "Missing IUSE=doc"
				fi
			fi
		fi

		base_src_prepare

		multilib_copy_sources
	}

	netsurf_src_configure() {
		netsurf_makeconf=(
			NSSHARED=${WORKDIR}/${NETSURF_BUILDSYSTEM}
			Q=
			CCOPT=
			CCNOOPT=
			CCDBG=
			LDDBG=
			AR="$(tc-getAR)"
			BUILD=$(usex debug debug release)
			DESTDIR="${D}"
			PREFIX="${EROOT}"usr
		)

		multilib-minimal_src_configure
	}

	netsurf_src_compile() {
		multilib-minimal_src_compile

		if has doc ${IUSE} ; then
			use doc && netsurf_make docs
		fi
	}

	netsurf_src_test() {
		multilib-minimal_src_test
	}

	netsurf_src_install() {
		multilib-minimal_src_install
	}

	multilib_src_configure() {
		sed -e "/^INSTALL_ITEMS/s: /lib: /$(get_libdir):g" \
			-i Makefile || die
		if [ -f ${PN}.pc.in ] ; then
			sed -e "/^libdir/s:/lib:/$(get_libdir):g" \
				-i ${PN}.pc.in || die
		fi
	}

	netsurf_make() {
		emake CC="$(tc-getCC)" LD="$(tc-getLD)" "${netsurf_makeconf[@]}" \
			COMPONENT_TYPE=lib-shared "$@"
		if use static-libs ; then
			emake CC="$(tc-getCC)" LD="$(tc-getLD)" "${netsurf_makeconf[@]}" \
				COMPONENT_TYPE=lib-static "$@"
		fi
	}

	multilib_src_compile() {
		netsurf_make
	}

	multilib_src_test() {
		netsurf_make test
	}

	multilib_src_test() {
		netsurf_make test
	}

	multilib_src_install() {
		netsurf_make install
	}

	multilib_src_install_all() {
		if has doc ${IUSE} ; then
			use doc && dohtml -r build/docs/html/*
		fi
	}
}

src_prepare() {
	netsurf_src_prepare
}

src_configure() {
	netsurf_src_configure

	netsurf_makeconf+=(
		WITH_EXPAT_BINDING=$(usex xml $(usex expat yes no) no)
		WITH_LIBXML_BINDING=$(usex xml $(usex expat no yes) no)
	)
}

src_compile() {
	netsurf_src_compile
}

src_test() {
	netsurf_src_test
}

src_install() {
	netsurf_src_install
}
