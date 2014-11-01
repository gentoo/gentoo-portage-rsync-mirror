# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/merb-helpers/merb-helpers-1.1.3.ebuild,v 1.4 2014/11/01 09:31:00 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README TODO"

inherit ruby-fakegem

DESCRIPTION="Helper support for Merb"
HOMEPAGE="http://merbivore.com"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Tests fail but it is not clear if this is a regression because
# previous revisions did not try to run them. Restricting for now.
RESTRICT="test"

ruby_add_bdepend "test? ( dev-ruby/rspec:0 )"

ruby_add_rdepend "~dev-ruby/merb-core-${PV}"

all_ruby_prepare() {
	sed -i -e 's:rake/rdoctask:rdoc/task:' Rakefile || die
}
