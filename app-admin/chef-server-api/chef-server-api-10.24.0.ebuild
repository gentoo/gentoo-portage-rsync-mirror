# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chef-server-api/chef-server-api-10.24.0.ebuild,v 1.1 2013/03/01 19:24:25 hollow Exp $

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

# specs require root access
RESTRICT="test"

RDEPEND=">=dev-db/couchdb-0.10.0
	>=net-misc/rabbitmq-server-1.7.0"

ruby_add_rdepend "~app-admin/chef-${PV}
	>=dev-ruby/dep_selector-0.0.3
	>=dev-ruby/merb-assets-1.1.0
	<dev-ruby/merb-assets-1.2
	>=dev-ruby/merb-core-1.1.0
	<dev-ruby/merb-core-1.2
	>=dev-ruby/merb-helpers-1.1.0
	<dev-ruby/merb-helpers-1.2
	>=dev-ruby/merb-param-protection-1.1.0
	<dev-ruby/merb-param-protection-1.2
	>=dev-ruby/mixlib-authentication-1.1.3
	>=dev-ruby/uuidtools-2.1.1
	<dev-ruby/uuidtools-2.2
	www-servers/thin"

each_ruby_install() {
	each_fakegem_install
	ruby_fakegem_doins -r app
	ruby_fakegem_doins -r config
	ruby_fakegem_doins -r public
}

all_ruby_install() {
	all_fakegem_install

	doinitd "${FILESDIR}/initd/chef-server-api"
	doconfd "${FILESDIR}/confd/chef-server-api"

	insinto /etc/chef
	doins "${FILESDIR}/server.rb"
}

pkg_postinst() {
	elog
	elog "You should edit /etc/chef/server.rb before starting the service with"
	elog "/etc/init.d/chef-server-api start"
	elog
}
