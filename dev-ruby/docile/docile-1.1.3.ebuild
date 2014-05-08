# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/docile/docile-1.1.3.ebuild,v 1.2 2014/05/08 05:58:10 graaff Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.md HISTORY.md"

inherit ruby-fakegem

DESCRIPTION="Turns any Ruby object into a DSL"
HOMEPAGE="http://ms-ati.github.io/docile/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

all_ruby_prepare() {
	sed -i -e '/require \"github\/markup\"/d' Rakefile || die
	sed -i -e "/require 'simplecov'/d" -e "/require 'coveralls'/d"\
		-e "/SimpleCov/,/end/d" spec/spec_helper.rb || die
}
