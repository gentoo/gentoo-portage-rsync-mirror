# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gonzui/gonzui-1.2-r2.ebuild,v 1.1 2011/01/15 01:55:39 matsuu Exp $

EAPI="2"
#USE_RUBY="ruby18 ruby19 ree18"
USE_RUBY="ruby18"
inherit autotools eutils ruby-ng

DESCRIPTION="source code search engine"
HOMEPAGE="http://gonzui.sourceforge.net/"
SRC_URI="mirror://sourceforge/gonzui/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bzip2 cvs gzip lha ocaml perl rpm subversion zip"

RESTRICT="test"

ruby_add_rdepend ">=dev-ruby/ruby-bdb-0.5.2 dev-ruby/ruby-progressbar"

COMMON_DEPEND=">=sys-libs/db-4.2 ocaml? ( dev-lang/ocaml )"
DEPEND="${DEPEND} ${COMMON_DEPEND}"
RDEPEND="${RDEPEND} ${COMMON_DEPEND}
	bzip2? ( app-arch/bzip2 )
	cvs? ( dev-vcs/cvs )
	gzip? ( app-arch/gzip )
	lha? ( app-arch/lha )
	perl? ( dev-perl/PPI )
	rpm? ( app-arch/rpm )
	subversion? ( dev-vcs/subversion )
	zip? ( app-arch/unzip )"

all_ruby_prepare() {
	epatch "${FILESDIR}/${PF}-gentoo.patch"
	cp "${FILESDIR}"/ebuild.rb "${S}"/langscan/ || die
	eautoreconf
}

each_ruby_configure() {
	econf || die
}

each_ruby_compile() {
	emake || die
}

each_ruby_test() {
	emake check || die
}

each_ruby_install() {
	emake DESTDIR="${D}" install || die
}

all_ruby_install() {
	mv "${D}"/etc/gonzuirc.sample "${D}"/etc/gonzuirc || die
	newinitd "${FILESDIR}"/gonzui.initd gonzui || die
	keepdir /var/{lib,log}/gonzui || die

	dodoc AUTHORS ChangeLog NEWS README || die
}

pkg_postinst() {
	elog "First, You need to import source codes into an index. For example, if"
	elog "you want to import the source codes of wget-1.9.1.tar.gz, run the"
	elog "following command."
	elog
	elog "# gonzui-import wget-1.9.1.tar.gz"
	elog
	elog "Then, you can run gonzui-server that works as a web-based search engine."
	elog
	elog "# gonzui-server"
	elog
	elog "Finally, you can access the search engine with your browser. The URL"
	elog "is http://localhost:46984/."
	elog
	elog "The database (gonzui.db) format has become incompatible with"
	elog "older versions."
	elog "Please restructure the database if you already have it."
}
