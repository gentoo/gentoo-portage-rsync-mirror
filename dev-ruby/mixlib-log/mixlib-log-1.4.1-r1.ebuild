# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mixlib-log/mixlib-log-1.4.1-r1.ebuild,v 1.1 2014/07/22 06:22:27 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_TEST="none"

RUBY_FAKEGEM_EXTRA_DOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Simple class based Log mechanism"
HOMEPAGE="http://github.com/opscode/mixlib-log"
SRC_URI="https://github.com/opscode/${PN}/tarball/${PV} -> ${P}.tgz"
RUBY_S="opscode-${PN}-*"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

ruby_add_bdepend "test? (
	dev-ruby/rspec:2
	dev-util/cucumber
)"

all_ruby_prepare() {
	# Avoid unneeded dependency on bundler.
	rm Gemfile || die
}

each_ruby_test() {
	ruby-ng_rspec
	ruby-ng_cucumber
}
