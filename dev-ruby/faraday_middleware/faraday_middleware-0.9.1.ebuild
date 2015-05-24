# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/faraday_middleware/faraday_middleware-0.9.1.ebuild,v 1.1 2015/05/24 22:56:46 robbat2 Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"
inherit ruby-fakegem eutils

DESCRIPTION="Various middleware for Faraday"
HOMEPAGE="https://github.com/lostisland/faraday_middleware"
SRC_URI="https://github.com/lostisland/faraday_middleware/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+parsexml +oauth +mashify +rashify"

ruby_add_rdepend "
	>=dev-ruby/faraday-0.7.4
	parsexml? ( >=dev-ruby/multi_xml-0.5.3 )
	oauth? ( >=dev-ruby/simple_oauth-0.1 )
	mashify? ( >=dev-ruby/hashie-1.2 )
	rashify? ( >=dev-ruby/rash-0.3 )"

all_ruby_prepare() {
	# Remove bundler support.
	rm Gemfile || die
	sed -i -e '/[Bb]undler/d' Rakefile || die
}

each_ruby_prepare() {
	# Make sure the test scripts use the right ruby interpreter
	sed -i -e 's:ruby:'${RUBY}':' script/* || die
}
