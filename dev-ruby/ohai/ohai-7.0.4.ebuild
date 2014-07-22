# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ohai/ohai-7.0.4.ebuild,v 1.1 2014/07/22 06:20:58 graaff Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem versionator

DESCRIPTION="Ohai profiles your system and emits JSON"
HOMEPAGE="http://wiki.opscode.com/display/chef/Ohai"
SRC_URI="https://github.com/opscode/${PN}/archive/${PV}.tar.gz -> ${P}.tgz"

LICENSE="Apache-2.0"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/mime-types-1.16:0
	dev-ruby/ipaddress
	dev-ruby/yajl-ruby
	dev-ruby/mixlib-cli
	>=dev-ruby/mixlib-config-2.0:2
	dev-ruby/mixlib-log
	>=dev-ruby/mixlib-shellout-1.2:0
	>=dev-ruby/systemu-2.5.2"

all_ruby_prepare() {
	rm Gemfile .rspec || die
	# Be more lenient to work with versions of systemu that we have in
	# the tree.
	sed -i -e 's/~> 2.5.2/>= 2.5.2/' ohai.gemspec || die

	# Remove the Darwin-specific tests that require additional
	# dependencies.
	rm -rf spec/unit/plugins/darwin || die

	# Avoid the ruby plugin tests because these always execute the
	# system ruby, rather than the current ruby.
	rm -rf spec/unit/plugins/ruby_spec.rb || die
}

all_ruby_install() {
	all_fakegem_install

	doman docs/man/man1/ohai.1
}
