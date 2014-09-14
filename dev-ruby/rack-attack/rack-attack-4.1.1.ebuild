# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rack-attack/rack-attack-4.1.1.ebuild,v 1.1 2014/09/14 01:48:18 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

# Skip integration tests since they require additional unpackaged
# dependencies and running daemons.
RUBY_FAKEGEM_TASK_TEST="test:units"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="A DSL for blocking & throttling abusive clients"
HOMEPAGE="https://github.com/kickstarter/rack-attack"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

ruby_add_rdepend "dev-ruby/rack"
ruby_add_bdepend "test? ( dev-ruby/activesupport
	dev-ruby/rack-test
	dev-ruby/minitest )"

all_ruby_prepare() {
	sed -i -e '/bundler/d' spec/spec_helper.rb || die

	# Remove
}
