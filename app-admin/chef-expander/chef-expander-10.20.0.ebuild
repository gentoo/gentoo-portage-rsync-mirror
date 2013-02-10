# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chef-expander/chef-expander-10.20.0.ebuild,v 1.1 2013/02/10 20:02:16 hollow Exp $

EAPI=4
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Configuration management tool"
HOMEPAGE="http://wiki.opscode.com/display/chef"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# specs require a live rabbitmq server
RESTRICT="test"

ruby_add_rdepend "~app-admin/chef-${PV}
	>=dev-ruby/amqp-0.6.7
	<dev-ruby/amqp-0.7
	>=dev-ruby/bunny-0.6.0
	>=dev-ruby/em-http-request-0.2.11
	<dev-ruby/em-http-request-0.3
	>=dev-ruby/eventmachine-0.12.10
	>=dev-ruby/fast_xs-0.7.3
	>=dev-ruby/highline-1.6.1
	<dev-ruby/highline-1.7
	>=dev-ruby/mixlib-log-1.2.0
	>=dev-ruby/uuidtools-2.1.1
	<dev-ruby/uuidtools-2.2
	>=dev-ruby/yajl-ruby-1.0
	<dev-ruby/yajl-ruby-2"

all_ruby_install() {
	all_fakegem_install

	doinitd "${FILESDIR}/initd/chef-expander"
	doconfd "${FILESDIR}/confd/chef-expander"

	keepdir /etc/chef /var/{lib,log,run}/chef
	fowners chef:chef /var/{lib,log,run}/chef
}
