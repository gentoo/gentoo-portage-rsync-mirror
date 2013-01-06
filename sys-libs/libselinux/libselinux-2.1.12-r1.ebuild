# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libselinux/libselinux-2.1.12-r1.ebuild,v 1.2 2012/11/17 16:55:33 swift Exp $

EAPI="4"
PYTHON_DEPEND="python? *"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 *-jython *-pypy-*"

inherit multilib python toolchain-funcs eutils

SEPOL_VER="2.1.8"

DESCRIPTION="SELinux userland library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20120924/${P}.tar.gz
	http://dev.gentoo.org/~swift/patches/${PN}/patchbundle-${P}-r1.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="python ruby static-libs"

RDEPEND=">=sys-libs/libsepol-${SEPOL_VER}
	>=dev-libs/libpcre-8.30-r2[static-libs?]
	ruby? ( dev-lang/ruby )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	ruby? ( dev-lang/swig )
	python? ( dev-lang/swig )"

S="${WORKDIR}/${P}"

pkg_setup() {
	if use python; then
		python_pkg_setup
	fi
}

src_unpack() {
	default
}

src_prepare() {
	# fix up paths for multilib
	sed -i \
		-e "/^LIBDIR/s/lib/$(get_libdir)/" \
		-e "/^SHLIBDIR/s/lib/$(get_libdir)/" \
		src/Makefile utils/Makefile || die

	EPATCH_MULTI_MSG="Applying libselinux patches ... " \
	EPATCH_SUFFIX="patch" \
	EPATCH_SOURCE="${WORKDIR}/gentoo-patches" \
	EPATCH_FORCE="yes" \
	epatch

	epatch_user
}

src_compile() {
	emake \
		AR="$(tc-getAR)" \
		CC="$(tc-getCC)" \
		LDFLAGS="-fPIC $($(tc-getPKG_CONFIG) libpcre --libs) ${LDFLAGS}" all || die

	if use python; then
		python_copy_sources src
		building() {
			emake CC="$(tc-getCC)" PYINC="-I$(python_get_includedir)" PYTHONLIBDIR="$(python_get_library -l)" PYPREFIX="python-$(python_get_version)" LDFLAGS="-fPIC $($(tc-getPKG_CONFIG) libpcre --libs) ${LDFLAGS}" pywrap
		}
		python_execute_function -s --source-dir src building
	fi

	if use ruby; then
		emake CC="$(tc-getCC)" rubywrap || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use python; then
		installation() {
			emake DESTDIR="${D}" PYLIBVER="python$(python_get_version)" PYPREFIX="python-$(python_get_version)" install-pywrap
		}
		python_execute_function -s --source-dir src installation
	fi

	if use ruby; then
		emake DESTDIR="${D}" install-rubywrap || die
	fi

	use static-libs || rm "${D}"/usr/lib*/*.a
}

pkg_postinst() {
	if use python; then
		python_mod_optimize selinux
	fi
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup selinux
	fi
}
