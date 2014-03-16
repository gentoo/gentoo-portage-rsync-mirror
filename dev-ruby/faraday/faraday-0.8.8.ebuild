# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/faraday/faraday-0.8.8.ebuild,v 1.2 2014/03/16 00:23:35 mrueg Exp $

EAPI=5

USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem eutils

DESCRIPTION="HTTP/REST API client library with pluggable components"
HOMEPAGE="http://github.com/lostisland/faraday"
SRC_URI="https://github.com/lostisland/faraday/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/multipart-post-1.2.0"
ruby_add_bdepend "test? (
		>=dev-ruby/test-unit-2.4
		dev-ruby/sinatra
		dev-ruby/net-http-persistent
		dev-ruby/patron
	)"

all_ruby_prepare() {
	# Remove bundler support.
	rm Gemfile || die
	sed -i -e '/[Bb]undler/d' test/helper.rb || die

	# Remove tests for adapters that are not packaged for Gentoo.
	rm test/adapters/em_http_test.rb test/adapters/em_synchrony_test.rb test/adapters/excon_test.rb test/adapters/typhoeus_test.rb || die
}

each_ruby_test() {
	each_fakegem_test

	# Sleep some time to allow the sinatra test server to die
	einfo "Waiting for test server to stop"
	sleep 10
}
