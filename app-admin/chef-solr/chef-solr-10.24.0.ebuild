# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chef-solr/chef-solr-10.24.0.ebuild,v 1.2 2014/12/28 09:41:10 graaff Exp $

EAPI=4
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="Configuration management tool"
HOMEPAGE="http://wiki.opscode.com/display/chef"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-misc/rabbitmq-server-1.7.2
	>=virtual/jre-1.6"

ruby_add_rdepend "~app-admin/chef-${PV}"

each_ruby_install() {
	each_fakegem_install
	ruby_fakegem_doins -r solr
}

all_ruby_install() {
	all_fakegem_install

	doinitd "${FILESDIR}/initd/chef-solr"
	doconfd "${FILESDIR}/confd/chef-solr"

	insinto /etc/chef
	doins "${FILESDIR}/solr.rb"
}

pkg_postinst() {
	elog
	elog "You need to run the chef-solr-installer script to setup the SOLR instance:"
	elog
	elog "    chef-solr-installer -c /etc/chef/solr.rb -u chef -g chef -f"
	elog
}
