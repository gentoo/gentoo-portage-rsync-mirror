# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ohai/ohai-6.22.0-r1.ebuild,v 1.1 2014/11/10 19:21:36 graaff Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="Ohai profiles your system and emits JSON"
HOMEPAGE="http://wiki.opscode.com/display/chef/Ohai"
SRC_URI="https://github.com/opscode/${PN}/archive/${PV}.tar.gz -> ${P}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "
	dev-ruby/ipaddress
	dev-ruby/yajl-ruby
	dev-ruby/mixlib-cli
	dev-ruby/mixlib-config
	dev-ruby/mixlib-log
	dev-ruby/mixlib-shellout
	>=dev-ruby/systemu-2.5.0"

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
}
