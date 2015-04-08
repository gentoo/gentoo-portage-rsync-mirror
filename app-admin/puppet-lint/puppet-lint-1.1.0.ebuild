# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/puppet-lint/puppet-lint-1.1.0.ebuild,v 1.1 2014/12/28 10:36:13 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit eutils ruby-fakegem

DESCRIPTION="A linter for puppet DSL"
HOMEPAGE="http://puppet-lint.com/"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

ruby_add_bdepend "test? (
	dev-ruby/rspec-its:1
	dev-ruby/rspec-collection_matchers:1 )"
