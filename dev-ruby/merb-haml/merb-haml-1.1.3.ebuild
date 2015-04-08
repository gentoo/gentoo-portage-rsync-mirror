# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/merb-haml/merb-haml-1.1.3.ebuild,v 1.3 2014/04/25 00:52:26 mrueg Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README TODO"

inherit ruby-fakegem

DESCRIPTION="Merb plugin that provides HAML support"
HOMEPAGE="http://merbivore.com"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:0 )"

ruby_add_rdepend ">=dev-ruby/haml-2.0.3
	~dev-ruby/merb-core-${PV}"
