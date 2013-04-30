# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/cocaine/cocaine-0.5.1.ebuild,v 1.1 2013/04/30 06:13:00 graaff Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="A small library for doing command lines"
HOMEPAGE="http://www.thoughtbot.com/projects/cocaine"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "dev-ruby/climate_control:0"

ruby_add_bdepend "
	test? (
		dev-ruby/bourne
		dev-ruby/mocha
	)"

all_ruby_prepare() {
	sed -i \
		-e '/git ls-files/d' \
		"${RUBY_FAKEGEM_GEMSPEC}" || die

	rm Gemfile* || die

	sed -i -e '/bundler/d' Rakefile || die

	sed -i -e '/pry/ s:^:#:' spec/spec_helper.rb || die
}
