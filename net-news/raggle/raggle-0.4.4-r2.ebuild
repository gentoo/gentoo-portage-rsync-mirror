# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/raggle/raggle-0.4.4-r2.ebuild,v 1.3 2012/09/23 08:12:13 phajdan.jr Exp $

EAPI=2
USE_RUBY="ruby18"

inherit ruby-ng

IUSE=""

DESCRIPTION="A console RSS aggregator, written in Ruby"
HOMEPAGE="http://www.raggle.org/"
SRC_URI="http://www.raggle.org/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc x86"

ruby_add_rdepend ">=dev-ruby/ncurses-ruby-0.8"

all_ruby_prepare() {
	sed -i -e 's~/usr/local~${D}/usr~' \
		-e '/cp -r \${DOCS}/d' \
		-e "/^DOCDIR/ s/raggle/${PF}/" \
		Makefile || die "sed failed"

	sed -i -e 's:#!/usr/bin/env ruby:#!/usr/bin/env ruby18:' raggle \
	|| die "sed failed"
}

each_ruby_install() {
	DESTDIR="${D}" emake install || die
}

all_ruby_install() {
	dodoc AUTHORS BUGS ChangeLog README TODO || die
}
