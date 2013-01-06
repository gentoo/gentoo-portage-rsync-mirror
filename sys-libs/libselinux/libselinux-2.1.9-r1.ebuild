# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libselinux/libselinux-2.1.9-r1.ebuild,v 1.4 2012/08/06 07:46:08 patrick Exp $

EAPI="4"
PYTHON_DEPEND="python? *"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython *-pypy-* 2.5 2.6 3.*"

inherit multilib python toolchain-funcs eutils

SEPOL_VER="2.1.4"

DESCRIPTION="SELinux userland library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20120216/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="python ruby"

RDEPEND=">=sys-libs/libsepol-${SEPOL_VER}
	ruby? ( dev-lang/ruby )"
DEPEND="${RDEPEND}
	ruby? ( dev-lang/swig )
	python? ( dev-lang/swig )"

pkg_setup() {
	if use python; then
		python_pkg_setup
	fi
}

src_prepare() {
	# fix up paths for multilib
	sed -i -e "/^LIBDIR/s/lib/$(get_libdir)/" "${S}/src/Makefile" \
		|| die "Fix for multilib LIBDIR failed."
	sed -i -e "/^SHLIBDIR/s/lib/$(get_libdir)/" "${S}/src/Makefile" \
		|| die "Fix for multilib SHLIBDIR failed."
	epatch "${FILESDIR}/${P}-mountsys.patch"
}

src_compile() {
	emake AR="$(tc-getAR)" CC="$(tc-getCC)" LDFLAGS="-fPIC ${LDFLAGS}" all || die

	if use python; then
		python_copy_sources src
		building() {
			emake CC="$(tc-getCC)" PYLIBVER="python$(python_get_version)" PYPREFIX="python-$(python_get_version)" LDFLAGS="-fPIC ${LDFLAGS}" pywrap
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
