# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsolv/libsolv-0.6.6.ebuild,v 1.3 2014/11/19 19:36:05 dilfridge Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
USE_RUBY=( ruby19 )
RUBY_OPTIONAL=yes
inherit python-single-r1 ruby-ng perl-module cmake-utils

DESCRIPTION="Library for solving packages and reading repositories"
HOMEPAGE="http://doc.opensuse.org/projects/libzypp/HEAD/ https://github.com/openSUSE/libsolv"
SRC_URI="https://github.com/openSUSE/libsolv/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="bzip2 lzma perl python ruby"

RDEPEND="
	app-arch/rpm
	dev-libs/expat
	sys-libs/db
	sys-libs/zlib
	virtual/udev
	bzip2? ( app-arch/bzip2 )
	lzma? ( app-arch/xz-utils )
	python? (
		${PYTHON_DEPS}
		dev-lang/swig:0
	)
	perl? (
		dev-lang/perl
		dev-lang/swig:0
	)
	ruby? (
		$(ruby_implementations_depend)
		dev-lang/swig:0
	)
"
DEPEND="${DEPEND}
	sys-devel/gettext
"

# ruby eclass :/
S="${WORKDIR}/${P}/"

pkg_setup() {
	use python && python-any-r1_pkg_setup
	use perl && perl_set_version
	use ruby && ruby-ng_pkg_setup
}

src_prepare() {
	# Enabling suse features also mess up headers detection
	# Can't be fixed upstream
	sed -i \
		-e "s:include <rpm/db.h>:include <db.h>:g" \
		ext/repo_rpmdb.c || die
	# respect ldflags ; fixed in next release
	sed \
		-e 's:LINK_FLAGS}:LINK_FLAGS} ${CMAKE_SHARED_LINKER_FLAGS}:g' \
		-i src/CMakeLists.txt \
		-i ext/CMakeLists.txt || die
	# mandir install ; won't be fixed upstream :-/
	sed -i \
		-e 's:MAN_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/man":MAN_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/share/man":g' \
		CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		"-DSUSE=1"
		"-DENABLE_SUSEREPO=1"
		"-DENABLE_HELIXREPO=1"
		"-DUSE_VENDORDIRS=1"
		$(cmake-utils_use_enable bzip2 ENABLE_BZIP2_COMPRESSION)
		$(cmake-utils_use_enable lzma ENABLE_LZMA_COMPRESSION)
		$(cmake-utils_use_enable perl PERL)
		$(cmake-utils_use_enable python PYTHON)
		$(cmake-utils_use_enable ruby RUBY)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	use perl && perl_delete_localpod
}
