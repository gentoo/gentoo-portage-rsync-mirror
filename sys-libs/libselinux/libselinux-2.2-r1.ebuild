# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libselinux/libselinux-2.2-r1.ebuild,v 1.2 2014/01/20 20:03:24 swift Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 python3_2 )
USE_RUBY="ruby18 ruby19"
RUBY_OPTIONAL="yes"

inherit multilib python-r1 toolchain-funcs eutils ruby-ng

SEPOL_VER="2.2"

DESCRIPTION="SELinux userland library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20131030/${P}.tar.gz
	http://dev.gentoo.org/~swift/patches/${PN}/patchbundle-${P}-r1.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="python ruby static-libs"

RDEPEND=">=sys-libs/libsepol-${SEPOL_VER}
	>=dev-libs/libpcre-8.30-r2[static-libs?]
	python? ( ${PYTHON_DEPS} )
	ruby? ( $(ruby_implementations_depend) )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	ruby? ( >=dev-lang/swig-2.0.9 )
	python? ( >=dev-lang/swig-2.0.9 )"

S="${WORKDIR}/${P}"

pkg_setup() {
	# prevent ruby-ng to mess if ruby is not asked for
	if use ruby; then
		ruby-ng_pkg_setup
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

	if use python; then
		BUILD_DIR="${S}/src"
		python_copy_sources
	fi
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
		building() {
			python_export PYTHON_INCLUDEDIR PYTHON_LIBPATH
			emake CC="$(tc-getCC)" PYINC="-I${PYTHON_INCLUDEDIR}" PYTHONLIBDIR="${PYTHON_LIBPATH}" PYPREFIX="${EPYTHON##*/}" LDFLAGS="-fPIC $($(tc-getPKG_CONFIG) libpcre --libs) ${LDFLAGS} -lpthread" pywrap
		}
		python_foreach_impl building
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
			emake DESTDIR="${D}" install-pywrap
		}
		python_foreach_impl installation
	fi

	if use ruby; then
		ruby-ng_src_install
	fi

	use static-libs || rm "${D}"/usr/lib*/*.a
}

pkg_postinst() {
	# Fix bug 473502
	for POLTYPE in ${POLICY_TYPES};
	do
		mkdir -p /etc/selinux/${POLTYPE}/contexts/files
		touch /etc/selinux/${POLTYPE}/contexts/files/file_contexts.local
	done
}
