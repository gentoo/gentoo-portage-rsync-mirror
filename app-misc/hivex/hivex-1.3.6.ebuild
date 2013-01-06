# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hivex/hivex-1.3.6.ebuild,v 1.1 2012/06/21 18:35:22 maksbotan Exp $

EAPI=4

WANT_AUTOMAKE="1.11"
AUTOTOOLS_IN_SOURCE_BUILD=1
AUTOTOOLS_AUTORECONF=1

USE_RUBY="ruby18"
RUBY_OPTIONAL=yes
PYTHON_DEPEND="python? 2:2.6"

inherit base autotools-utils perl-app python

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
				dev-perl/Test-Pod-Coverage ) )
	ruby? ( dev-ruby/rake )
	"
PATCHES=("${FILESDIR}"/"${PV}"/*.patch)
DOCS=(README)

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
		python_need_rebuild
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
}

src_test() {
	autotools-utils_src_compile check
}

src_install() {
	strip-linguas -i po

	autotools-utils_src_install "LINGUAS=""${LINGUAS}"""

	if use perl; then
		fixlocalpod
	fi
}
