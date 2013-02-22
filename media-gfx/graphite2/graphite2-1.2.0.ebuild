# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphite2/graphite2-1.2.0.ebuild,v 1.14 2013/02/22 18:39:52 zmedico Exp $

EAPI=4

PYTHON_DEPEND="test? 2"
GENTOO_DEPEND_ON_PERL="no"
inherit base cmake-utils perl-module python

DESCRIPTION="Library providing rendering capabilities for complex non-Roman writing systems"
HOMEPAGE="http://graphite.sil.org/"
SRC_URI="mirror://sourceforge/silgraphite/${PN}/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~ppc64 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~x64-macos ~x64-solaris"
IUSE="perl test"

RDEPEND="
	perl? ( dev-lang/perl )
"
DEPEND="${RDEPEND}
	perl? ( virtual/perl-Module-Build )
	test? (
		dev-libs/glib:2
		media-libs/fontconfig
		media-libs/silgraphite
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-1.1.0-includes-libs-perl.patch"
	"${FILESDIR}/${PN}-1.0.2-no_harfbuzz_tests.patch"
	"${FILESDIR}/${PN}-1.0.3-no-test-binaries.patch"
	"${FILESDIR}/${PN}-1.2.0-solaris.patch"
)

pkg_setup() {
	use perl && perl-module_pkg_setup
	if use test; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	base_src_prepare

	# fix perl linking
	if use perl; then
		_check_build_dir init
		sed -i \
			-e "s:@BUILD_DIR@:\"${CMAKE_BUILD_DIR}/src\":" \
			contrib/perl/Build.PL || die
	fi

	# make tests optional
	if ! use test; then
		sed -i \
			-e '/tests/d' \
			CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		"-DVM_MACHINE_TYPE=direct"
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	if use perl; then
		cd contrib/perl
		perl-module_src_prep
		perl-module_src_compile
	fi
}

src_test() {
	cmake-utils_src_test
	if use perl; then
		cd contrib/perl
		perl-module_src_test
	fi
}

src_install() {
	cmake-utils_src_install
	if use perl; then
		cd contrib/perl
		perl-module_src_install
		fixlocalpod
	fi

	find "${ED}" -name '*.la' -exec rm -f {} +

}
