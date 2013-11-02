# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/diakonos/diakonos-0.9.1-r1.ebuild,v 1.1 2013/11/02 20:10:30 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20"
inherit ruby-ng

DESCRIPTION="A Linux editor for the masses"
HOMEPAGE="http://diakonos.pist0s.ca"
SRC_URI="http://diakonos.pist0s.ca/archives/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

ruby_add_bdepend "doc? ( dev-ruby/yard )
	test? ( dev-ruby/bacon )"

each_ruby_install() {
	${RUBY} install.rb --dest-dir "${D}" --doc-dir /usr/share/doc/${P} || die "install failed"
}

all_ruby_install() {
	if use doc; then
		rake docs || die
		dodoc -r doc/*
	fi
}

each_ruby_test() {
	${RUBY} -S bacon -Ilib spec/*.rb spec/*/*.rb || die
}
