# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/oauth2/oauth2-1.0.0.ebuild,v 1.4 2014/08/25 14:17:03 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_TEST="none"
RUBY_FAKEGEM_TASK_DOC="doc:rdoc"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem eutils

DESCRIPTION="Ruby wrapper for the OAuth 2.0 protocol built with a similar style to the original OAuth gem"
HOMEPAGE="http://github.com/intridea/oauth2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/faraday-0.8
	>=dev-ruby/jwt-1.0 =dev-ruby/jwt-1*
	>=dev-ruby/multi_json-1.3 =dev-ruby/multi_json-1*
	>=dev-ruby/multi_xml-0.5:0
	>=dev-ruby/rack-1.2"
ruby_add_bdepend "test? ( >=dev-ruby/rspec-2.5.0:2 )"

all_ruby_prepare() {
	sed -i -e '/simplecov/,/^end/ s:^:#:' spec/helper.rb || die

	sed -i -e '/yardstick/,/^end/ s:^:#:' Rakefile || die
}

each_ruby_test() {
	CI=true ${RUBY} -S rspec spec || die
}
