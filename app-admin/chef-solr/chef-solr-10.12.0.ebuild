# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chef-solr/chef-solr-10.12.0.ebuild,v 1.1 2012/08/11 12:45:49 hollow Exp $

EAPI=4
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="Configuration management tool"
HOMEPAGE="http://wiki.opscode.com/display/chef"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-misc/rabbitmq-server-1.7.2
	virtual/jre:1.6"

ruby_add_rdepend "~app-admin/chef-${PV}"

each_ruby_test() {
	${RUBY} -S rspec spec || die
}

each_ruby_install() {
	each_fakegem_install
	ruby_fakegem_doins -r solr
}

all_ruby_install() {
	all_fakegem_install

	doinitd "${FILESDIR}/initd/chef-solr"
	doconfd "${FILESDIR}/confd/chef-solr"

	keepdir /etc/chef /var/lib/chef /var/log/chef /var/run/chef

	insinto /etc/chef
	doins "${FILESDIR}/solr.rb"

	fowners chef:chef /etc/chef/{,solr.rb}
	fowners chef:chef /var/{lib,log,run}/chef
}

pkg_postinst() {
	elog
	elog "You need to run the chef-solr-installer script to setup the SOLR instance:"
	elog
	elog "    chef-solr-installer -c /etc/chef/solr.rb -u chef -g chef -f"
	elog
}
