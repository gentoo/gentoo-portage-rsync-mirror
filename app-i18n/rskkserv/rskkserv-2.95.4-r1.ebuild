# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/rskkserv/rskkserv-2.95.4-r1.ebuild,v 1.3 2011/04/13 15:19:12 ulm Exp $

EAPI="2"
# dev-ruby/ruby-tcpwrap doesn't work with jruby
# rskkserv doesn't work with ruby19
USE_RUBY="ruby18 ree18"

inherit eutils ruby-ng

DESCRIPTION="rskkserv is an alternative version of skkserv implemented by Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=rskkserv"
SRC_URI="http://www.unixuser.org/~ysjj/rskkserv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

ruby_add_bdepend dev-ruby/ruby-tcpwrap
RDEPEND="${DEPEND}
	app-i18n/skk-jisyo"

RUBY_PATCHES=( "${FILESDIR}/${P}-gentoo.patch" )
all_src_prepare() {
	sed -i -e "s:with_RUBY:with_ruby:" configure || die
}

each_ruby_configure() {
	econf \
		--with-dicfile=/usr/share/skk/SKK-JISYO.L \
		--with-cachedir=/var/lib/rskkserv \
		--with-piddir=/var/run \
		--with-logdir=/var/log \
		|| die "econf failed"
	cd ext; ${RUBY} extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	emake || die "emake failed"
}

each_ruby_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

all_ruby_install() {
	newinitd "${FILESDIR}"/rskkserv-2.95.initd rskkserv || die

	keepdir /var/lib/rskkserv || die

	dodoc ChangeLog TODO || die
	cd doc
	dodoc rskkserv.conf.sample conf-o2n.rb || die
	newdoc README.old README || die
	doman rskkserv.1 || die
	cp rskkserv.1.ja_JP.eucJP "${T}"/rskkserv.1 || die
	doman -i18n=ja "${T}"/rskkserv.1 || die
}

pkg_postinst() {
	elog
	elog "If you want to add auxiliary dictionaries (e.g. SKK-JISYO.JIS2,"
	elog "SKK-JISYO.jinmei, SKK-JISYO.2ch and so on) you need to emerge"
	elog "app-i18n/skk-jisyo-extra and uncomment dictionary entries in"
	elog "/etc/rskkserv.conf manually."
	elog
	elog "If you are upgrading from 2.94.x, you may want to use"
	elog "conf-o2n.rb in /usr/share/doc/${PF} to convert configuration"
	elog "file into new format."
	elog
}
