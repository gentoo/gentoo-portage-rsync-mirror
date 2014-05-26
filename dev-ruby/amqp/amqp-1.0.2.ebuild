# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amqp/amqp-1.0.2.ebuild,v 1.2 2014/05/26 05:42:03 mrueg Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.md"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_BINWRAP=""

inherit versionator ruby-fakegem

DESCRIPTION="AMQP client implementation in Ruby/EventMachine"
HOMEPAGE="http://amqp.rubyforge.org/"

LICENSE="Ruby"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/multi_json dev-ruby/evented-spec )"
ruby_add_rdepend ">=dev-ruby/eventmachine-0.12.4
	>=dev-ruby/amq-client-1.0.2
	>=dev-ruby/amq-protocol-1.3.0"

all_ruby_prepare() {
	#rm Gemfile || die
	sed -i -e '/[Bb]undler/ s:^:#:' -e '/effin_utf8/ s:^:#:' spec/spec_helper.rb || die

	# Many specs require a live rabbit server, but only root can start
	# an instance. Skip these specs for now.
	rm -rf spec/integration spec/unit/amqp/connection_spec.rb || die

	sed -i -e '/raises an exception/ s:^:#:' spec/unit/amqp/channel_id_allocation_spec.rb || die
}

all_ruby_install() {
	dodoc -r docs examples
}
