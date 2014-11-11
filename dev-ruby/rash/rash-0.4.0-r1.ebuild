# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rash/rash-0.4.0-r1.ebuild,v 1.4 2014/11/11 11:05:41 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Rash is an extension to Hashie"
HOMEPAGE="https://github.com/tcocca/rash"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/hashie-2.0.0"

all_ruby_prepare() {
	rm Gemfile || die
	sed -i -e '/[Bb]undler/d' Rakefile || die
}
