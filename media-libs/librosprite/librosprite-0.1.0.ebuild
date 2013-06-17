# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/librosprite/librosprite-0.1.0.ebuild,v 1.1 2013/06/17 17:35:09 xmw Exp $

EAPI=5

inherit base toolchain-funcs multilib-minimal

DESCRIPTION="framebuffer abstraction library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/librosprite/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""

RDEPEND=""
DEPEND=""

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
