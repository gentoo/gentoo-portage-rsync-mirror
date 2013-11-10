# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libsemanage/libsemanage-2.2.ebuild,v 1.2 2013/11/10 14:17:26 swift Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 python3_2 )
USE_RUBY="ruby18 ruby19"
RUBY_OPTIONAL="yes"

inherit multilib python-r1 toolchain-funcs eutils ruby-ng

SEPOL_VER="2.2"
SELNX_VER="2.2"

DESCRIPTION="SELinux kernel and policy management library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20131030/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python ruby"

RDEPEND=">=sys-libs/libsepol-${SEPOL_VER}
	>=sys-libs/libselinux-${SELNX_VER}
	dev-libs/ustr
	sys-process/audit
	ruby? (
		$(ruby_implementations_depend)
	)"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	ruby? ( >=dev-lang/swig-2.0.4-r1 )
	python? (
		>=dev-lang/swig-2.0.4-r1
		${PYTHON_DEPS}
	)"

S="${WORKDIR}/${P}"

# tests are not meant to be run outside of the
# full SELinux userland repo
RESTRICT="test"

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
	echo "# Set this to true to save the linked policy." >> "${S}/src/semanage.conf"
	echo "# This is normally only useful for analysis" >> "${S}/src/semanage.conf"
	echo "# or debugging of policy." >> "${S}/src/semanage.conf"
	echo "save-linked=false" >> "${S}/src/semanage.conf"
	echo >> "${S}/src/semanage.conf"
	echo "# Set this to 0 to disable assertion checking." >> "${S}/src/semanage.conf"
	echo "# This should speed up building the kernel policy" >> "${S}/src/semanage.conf"
	echo "# from policy modules, but may leave you open to" >> "${S}/src/semanage.conf"
	echo "# dangerous rules which assertion checking" >> "${S}/src/semanage.conf"
	echo "# would catch." >> "${S}/src/semanage.conf"
	echo "expand-check=1" >> "${S}/src/semanage.conf"
	echo >> "${S}/src/semanage.conf"
	echo "# Modules in the module store can be compressed" >> "${S}/src/semanage.conf"
	echo "# with bzip2.  Set this to the bzip2 blocksize" >> "${S}/src/semanage.conf"
	echo "# 1-9 when compressing.  The higher the number," >> "${S}/src/semanage.conf"
	echo "# the more memory is traded off for disk space." >> "${S}/src/semanage.conf"
	echo "# Set to 0 to disable bzip2 compression." >> "${S}/src/semanage.conf"
	echo "bzip-blocksize=0" >> "${S}/src/semanage.conf"
	echo >> "${S}/src/semanage.conf"
	echo "# Reduce memory usage for bzip2 compression and" >> "${S}/src/semanage.conf"
	echo "# decompression of modules in the module store." >> "${S}/src/semanage.conf"
	echo "bzip-small=true" >> "${S}/src/semanage.conf"

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

	emake -C src CC="$(tc-getCC)" RUBY="${RUBY}" rubywrap || die
}

src_compile() {
	emake AR="$(tc-getAR)" CC="$(tc-getCC)" all || die

	if use python; then
		building() {
			python_export PYTHON_INCLUDEDIR PYTHON_LIBPATH
			emake CC="$(tc-getCC)" PYINC="-I${PYTHON_INCLUDEDIR}" PYTHONLBIDIR="${PYTHON_LIBPATH}" PYPREFIX="${EPYTHON##*/}" "$@"
		}
		python_foreach_impl building swigify
		python_foreach_impl building pywrap
	fi

	if use ruby; then
		ruby-ng_src_compile
	fi
}

each_ruby_install() {
	local RUBYLIBVER=$(${RUBY} -e 'print RUBY_VERSION.split(".")[0..1].join(".")')

	cd "${WORKDIR}/${P}/src-ruby-${RUBYLIBVER}"
	emake -C src RUBY="${RUBY}" DESTDIR="${D}" install-rubywrap || die
}

src_install() {
	emake \
		DESTDIR="${D}" \
		LIBDIR="${D}usr/$(get_libdir)" \
		SHLIBDIR="${D}$(get_libdir)" \
		install || die
	dosym "../../$(get_libdir)/libsemanage.so.1" "/usr/$(get_libdir)/libsemanage.so" || die

	if use python; then
		installation() {
			emake DESTDIR="${D}" install-pywrap
		}
		python_foreach_impl installation
	fi

	if use ruby; then
		ruby-ng_src_install
	fi
}
