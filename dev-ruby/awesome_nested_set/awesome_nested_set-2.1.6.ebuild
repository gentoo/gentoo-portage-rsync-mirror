# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/awesome_nested_set/awesome_nested_set-2.1.6.ebuild,v 1.1 2014/04/18 18:13:18 mrueg Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="An awesome nested set implementation for Active Record"
HOMEPAGE="https://github.com/collectiveidea/awesome_nested_set"
SRC_URI="https://github.com/collectiveidea/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

ruby_add_rdepend "dev-ruby/activerecord:3.2"

ruby_add_bdepend "test? ( dev-ruby/combustion
	dev-ruby/rspec-rails )"

all_ruby_prepare() {
	sed -i -e '/[Bb]undler/d' Rakefile spec/spec_helper.rb || die
	sed -i -e "/require 'active_record'/i \ require 'test/unit' \n gem 'activerecord', '~> 3.2'" spec/spec_helper.rb || die
}
