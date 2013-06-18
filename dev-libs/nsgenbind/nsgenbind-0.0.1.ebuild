# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nsgenbind/nsgenbind-0.0.1.ebuild,v 1.1 2013/06/18 09:42:58 xmw Exp $

EAPI=5

inherit base toolchain-funcs multilib-minimal

DESCRIPTION="generate javascript to dom bindings from w3c webidl files"
HOMEPAGE="http://www.netsurf-browser.org/"

LICENSE="MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""

RDEPEND=""
DEPEND="virtual/yacc"

PATCHES=( "${FILESDIR}"/${P}-bison-2.6.patch )
NETSURF_COMPONENT_TYPE=binary

### future context of netsurf.eclass

NETSURF_BUILDSYSTEM=${NETSURF_BUILDSYSTEM:-buildsystem-1.0}
NETSURF_COMPONENT_TYPE=${NETSURF_COMPONENT_TYPE:-lib-shared lib-static}
SRC_URI=${SRC_URI:-http://download.netsurf-browser.org/libs/releases/${P}-src.tar.gz}
SRC_URI+="
	http://download.netsurf-browser.org/libs/releases/${NETSURF_BUILDSYSTEM}.tar.gz -> netsurf-${NETSURF_BUILDSYSTEM}.tar.gz"
IUSE+=" debug"
if has lib-static ${NETSURF_COMPONENT_TYPE} ; then
	IUSE+=" static-libs"
fi
if has doc ${IUSE} ; then
	DEPEND+="
	doc? ( app-doc/doxygen )"
fi
DEPEND+="
	virtual/pkgconfig"
pkg_setup(){
	netsurf_src_prepare() {
		base_src_prepare

		multilib_copy_sources
	}

	netsurf_src_configure() {
		netsurf_makeconf=(
			NSSHARED=${WORKDIR}/${NETSURF_BUILDSYSTEM}
			Q=
			HOST_CC="\$(CC)"
			CCOPT=
			CCNOOPT=
			CCDBG=
			LDDBG=
			AR="$(tc-getAR)"
			BUILD=$(usex debug debug release)
			PREFIX="${EROOT}"usr
		)

		multilib-minimal_src_configure
	}

	netsurf_src_compile() {
		multilib-minimal_src_compile "$@"

		if has doc ${USE} ; then
			netsurf_make "$@" docs
		fi
	}

	netsurf_src_test() {
		multilib-minimal_src_test "$@"
	}

	netsurf_src_install() {
		multilib-minimal_src_install "$@"
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
		for COMPONENT_TYPE in ${NETSURF_COMPONENT_TYPE} ; do
			if [ "${COMPONENT_TYPE}" == "lib-static" ] ; then
				if ! use static-libs ; then
					continue
				fi
			fi
			emake CC="$(tc-getCC)" LD="$(tc-getLD)" "${netsurf_makeconf[@]}" \
				COMPONENT_TYPE=${COMPONENT_TYPE} "$@"
		done
	}

	multilib_src_compile() {
		netsurf_make "$@"
	}

	multilib_src_test() {
		netsurf_make test "$@"
	}

	multilib_src_install() {
		#DEFAULT_ABI may not be the last.
		#install to clean dir, rename binaries, move everything back
		if [ "${ABI}" != "${DEFAULT_ABI}" ] ; then
			netsurf_make DESTDIR="${D}"${ABI} install "$@"
			if [ "${ABI}" != "${DEFAULT_ABI}" ] ; then
				find "${D}"${ABI}/usr/bin -type f -exec mv {} {}.${ABI} \;
			fi
			mv "${D}"${ABI}/* "${D}" || die
			rmdir "${D}"${ABI} || die
		else
			netsurf_make DESTDIR="${D}" install "$@"
		fi
	}

	multilib_src_install_all() {
		if has doc ${USE} ; then
			dohtml -r build/docs/html/*
		fi
	}
}

src_prepare() {
	sed -e '/CFLAGS := -/s|:=|+=|' \
		-i Makefile || die
	sed -e '/CFLAGS/s: -g : :' \
		-i src/Makefile || die

	netsurf_src_prepare
}

src_configure() {
	netsurf_src_configure
}

src_compile() {
	netsurf_src_compile
}

src_install() {
	netsurf_src_install
}
