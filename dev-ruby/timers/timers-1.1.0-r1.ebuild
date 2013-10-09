# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/timers/timers-1.1.0-r1.ebuild,v 1.1 2013/10/09 01:34:56 mrueg Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

inherit ruby-fakegem

DESCRIPTION="Pure Ruby one-shot and periodic timers"
HOMEPAGE="https://github.com/tarcieri/timers"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

all_ruby_prepare() {
	rm Gemfile || die
	sed -i -e '/bundler/ s:^:#:' spec/spec_helper.rb || die
}
