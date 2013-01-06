# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/mongrel_cluster/mongrel_cluster-1.0.5-r1.ebuild,v 1.3 2012/04/30 06:51:31 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"
RUBY_FAKEGEM_EXTRAINSTALL="resources"

inherit ruby-fakegem

DESCRIPTION="Mongrel plugin that provides commands and Capistrano tasks for managing multiple Mongrel processes"
HOMEPAGE="http://mongrel.rubyforge.org/docs/mongrel_cluster.html"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=www-servers/mongrel-1.0.2
	>=dev-ruby/gem_plugin-0.2.3"

all_ruby_install() {
	all_fakegem_install

	newinitd "${FILESDIR}/mongrel_cluster" mongrel_cluster
}
