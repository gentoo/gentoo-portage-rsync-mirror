# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libselinux/libselinux-2.1.13-r3.ebuild,v 1.1 2013/06/23 08:30:57 swift Exp $

EAPI="4"
PYTHON_DEPEND="python? *"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 *-jython *-pypy-*"
USE_RUBY="ruby18 ruby19"
RUBY_OPTIONAL="yes"

inherit multilib python toolchain-funcs eutils ruby-ng

SEPOL_VER="2.1.9"

DESCRIPTION="SELinux userland library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20130423/${P}.tar.gz
	http://dev.gentoo.org/~swift/patches/${PN}/patchbundle-${P}-r3.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python ruby static-libs"

RDEPEND=">=sys-libs/libsepol-${SEPOL_VER}
	>=dev-libs/libpcre-8.30-r2[static-libs?]
	ruby? ( $(ruby_implementations_depend) )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	ruby? ( >=dev-lang/swig-2.0.9 )
	python? ( >=dev-lang/swig-2.0.9 )"

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

each_ruby_compile() {
	local RUBYLIBVER=$(${RUBY} -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
	cd "${WORKDIR}/${P}"
	cp -r src src-ruby-${RUBYLIBVER}
	cd src-ruby-${RUBYLIBVER}

	if [[ "${RUBYLIBVER}" == "1.8" ]]; then
		emake CC="$(tc-getCC)" RUBY="${RUBY}" RUBYINC="-I$(ruby_get_hdrdir)" LDFLAGS="-fPIC $($(tc-getPKG_CONFIG) libpcre --libs) -lpthread ${LDFLAGS}" rubywrap || die
	else
		emake CC="$(tc-getCC)" RUBY="${RUBY}" LDFLAGS="-fPIC $($(tc-getPKG_CONFIG) libpcre --libs) ${LDFLAGS} -lpthread" rubywrap || die
	fi
}

src_compile() {
	tc-export RANLIB
	emake \
		AR="$(tc-getAR)" \
		CC="$(tc-getCC)" \
		LDFLAGS="-fPIC $($(tc-getPKG_CONFIG) libpcre --libs) ${LDFLAGS} -lpthread" all || die

	if use python; then
		python_copy_sources src
		building() {
			emake CC="$(tc-getCC)" PYINC="-I$(python_get_includedir)" PYTHONLIBDIR="$(python_get_library -l)" PYPREFIX="python-$(python_get_version)" LDFLAGS="-fPIC $($(tc-getPKG_CONFIG) libpcre --libs) ${LDFLAGS} -lpthread" pywrap
		}
		python_execute_function -s --source-dir src building
	fi

	if use ruby; then
		ruby-ng_src_compile
	fi
}

each_ruby_install() {
	local RUBYLIBVER=$(${RUBY} -e 'print RUBY_VERSION.split(".")[0..1].join(".")')

	cd "${WORKDIR}/${P}/src-ruby-${RUBYLIBVER}"
	emake RUBY="${RUBY}" DESTDIR="${D}" install-rubywrap || die
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
		ruby-ng_src_install
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
