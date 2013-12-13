# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/adhearsion-loquacious/adhearsion-loquacious-1.9.3.ebuild,v 1.1 2013/12/13 09:02:40 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"
RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="Descriptive configuration files for Ruby written in Ruby"
HOMEPAGE="https://rubygems.org/gems/adhearsion-loquacious"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

all_ruby_prepare() {
	sed -i -e "/guard/d"\
		-e "/git ls-files/d"\
		-e "s/, \[\"~> 2.7.0\"\]//"\
		-e "/gntp/d"\
		loquacious.gemspec || die
}
