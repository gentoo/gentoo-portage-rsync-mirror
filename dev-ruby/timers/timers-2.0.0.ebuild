# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/timers/timers-2.0.0.ebuild,v 1.2 2014/08/12 22:44:55 blueness Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

inherit ruby-fakegem

DESCRIPTION="Pure Ruby one-shot and periodic timers"
HOMEPAGE="https://github.com/tarcieri/timers"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~ppc64"
IUSE=""

ruby_add_rdepend "dev-ruby/hitimes"

all_ruby_prepare() {
	rm Gemfile || die
	sed -i -e '/bundler/ s:^:#:' spec/spec_helper.rb || die
	sed -i -e '/coveralls/ s:^:#:' spec/spec_helper.rb || die
	sed -i -e '/Coveralls/ s:^:#:' spec/spec_helper.rb || die
}
