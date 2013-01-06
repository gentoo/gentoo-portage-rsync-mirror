# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/puppet-lint/puppet-lint-0.2.1.ebuild,v 1.1 2012/11/06 05:47:20 antarus Exp $

EAPI="4"
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_TEST="rspec"
RUBY_FAKEGEM_EXTRADOC="README*"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit eutils ruby-fakegem

DESCRIPTION="A linter for puppet DSL."
HOMEPAGE="http://puppet-lint.com/"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

ruby_add_rdepend "
dev-ruby/rspec
dev-ruby/rake"

DEPEND="${DEPEND}"
RDEPEND="${RDEPEND}"
