# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chef-server-webui/chef-server-webui-10.24.0.ebuild,v 1.2 2013/03/07 08:10:46 hollow Exp $

EAPI=4
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem user

DESCRIPTION="Configuration management tool"
HOMEPAGE="http://wiki.opscode.com/display/chef"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-db/couchdb-0.10.0
	>=net-misc/rabbitmq-server-1.7.0"

ruby_add_rdepend "dev-ruby/coderay
	>=dev-ruby/extlib-0.9.16
	dev-ruby/haml
	<dev-ruby/sass-3.2
	>=dev-ruby/merb-assets-1.1.0
	<dev-ruby/merb-assets-1.2
	>=dev-ruby/merb-core-1.1.0
	<dev-ruby/merb-core-1.2
	>=dev-ruby/merb-haml-1.1.0
	<dev-ruby/merb-haml-1.2
	>=dev-ruby/merb-helpers-1.1.0
	<dev-ruby/merb-helpers-1.2
	>=dev-ruby/merb-param-protection-1.1.0
	<dev-ruby/merb-param-protection-1.2
	>=dev-ruby/rack-1.4.5
	dev-ruby/ruby-openid
	www-servers/thin"

pkg_setup() {
	enewgroup chef
	enewuser chef -1 -1 /var/lib/chef chef
}

each_ruby_install() {
	each_fakegem_install
	ruby_fakegem_doins -r app
	ruby_fakegem_doins -r config
	ruby_fakegem_doins config.ru
	ruby_fakegem_doins -r public

	# create unversioned path for passenger/rack integration
	dodir /var/lib/chef/rack
	dosym $(ruby_fakegem_gemsdir)/gems/${P} /var/lib/chef/rack/webui
}

all_ruby_install() {
	all_fakegem_install

	doinitd "${FILESDIR}/initd/chef-server-webui"
	doconfd "${FILESDIR}/confd/chef-server-webui"

	insinto /etc/chef
	doins "${FILESDIR}/webui.rb"
}

pkg_postinst() {
	elog
	elog "You should edit or create /etc/chef/webui.rb before starting the service"
	elog "with /etc/init.d/chef-server-webui start"
	elog
}
