# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gonzui/gonzui-1.2-r1.ebuild,v 1.5 2010/12/02 01:21:49 flameeyes Exp $

inherit autotools eutils ruby

USE_RUBY="ruby18"

DESCRIPTION="source code search engine"
HOMEPAGE="http://gonzui.sourceforge.net/"
SRC_URI="mirror://sourceforge/gonzui/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ocaml perl"
RESTRICT="test"

DEPEND="=dev-lang/ruby-1.8*
	>=sys-libs/db-4.2
	>=dev-ruby/ruby-bdb-0.5.2
	dev-ruby/ruby-progressbar
	ocaml? ( dev-lang/ocaml )
	perl? ( dev-perl/PPI )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	cp "${FILESDIR}"/ebuild.rb "${S}"/langscan/ || die
	eautoreconf
}

src_compile() {
	econf
	# bug #297463
	emake -j1 || die "emake failed"
}

src_install() {
	ruby_src_install
	mv "${D}"/etc/gonzuirc.sample "${D}"/etc/gonzuirc
	doinitd "${FILESDIR}"/gonzui || die
	keepdir /var/lib/gonzui
	keepdir /var/log/gonzui
}

pkg_postinst() {
	elog "The database (gonzui.db) format has become incompatible with"
	elog "older versions."
	elog "Please restructure the database if you already have it."
}
