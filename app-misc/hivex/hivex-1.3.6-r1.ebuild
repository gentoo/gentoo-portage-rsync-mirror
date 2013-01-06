# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hivex/hivex-1.3.6-r1.ebuild,v 1.1 2012/09/16 08:59:18 pinkbyte Exp $

EAPI=4

WANT_AUTOMAKE="1.11"
AUTOTOOLS_IN_SOURCE_BUILD=1
AUTOTOOLS_AUTORECONF=1

USE_RUBY="ruby18"
RUBY_OPTIONAL=yes
PYTHON_DEPEND="python? 2:2.6"

inherit autotools-utils eutils perl-app python

DESCRIPTION="Library for reading and writing Windows Registry 'hive' binary files"
HOMEPAGE="http://libguestfs.org"
SRC_URI="http://libguestfs.org/download/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ocaml readline perl python test static-libs ruby"

RDEPEND="virtual/libiconv
	virtual/libintl
	dev-libs/libxml2:2
	ocaml? ( dev-lang/ocaml[ocamlopt]
			 dev-ml/findlib[ocamlopt]
			 )
	readline? ( sys-libs/readline )
	perl? ( dev-perl/IO-stringy )
	"

DEPEND="${RDEPEND}
	dev-lang/perl
	perl? (
	 	test? ( dev-perl/Pod-Coverage
			dev-perl/Test-Pod-Coverage )
	      )
	ruby? ( dev-ruby/rake )
	"
PATCHES=("${FILESDIR}"/"${PVR}"/disable_automagic_cumulative_patch.patch )

DOCS=(README)

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
		python_need_rebuild
	fi
	if use perl; then
		perl-module_pkg_setup
	fi
}

src_prepare() {
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_with readline)
		$(use_enable ocaml)
		$(use_enable perl)
		--enable-nls
		$(use_enable python)
		$(use_enable ruby)
		--disable-rpath )

	autotools-utils_src_configure

	if use perl; then
		pushd perl
		perl-app_src_configure
		popd
	fi
}

src_compile() {
	autotools-utils_src_compile
}

src_test() {
	if use perl;then
		pushd perl
		perl-app_src_install
		popd
	fi

	autotools-utils_src_compile check
}

src_install() {
	strip-linguas -i po

	autotools-utils_src_install "LINGUAS=""${LINGUAS}"""

	if use perl; then
		fixlocalpod
	fi
}
