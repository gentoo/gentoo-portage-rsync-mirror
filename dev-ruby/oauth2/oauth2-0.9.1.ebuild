# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/oauth2/oauth2-0.9.1.ebuild,v 1.1 2013/04/13 06:23:50 graaff Exp $

EAPI=5

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_TEST="none"
RUBY_FAKEGEM_TASK_DOC="doc:rdoc"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem eutils

DESCRIPTION="Ruby wrapper for the OAuth 2.0 protocol built with a similar style to the original OAuth gem."
HOMEPAGE="http://github.com/intridea/oauth2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/faraday-0.8
	>=dev-ruby/httpauth-0.1
	>=dev-ruby/jwt-0.1.4
	>=dev-ruby/multi_json-1.0.3
	>=dev-ruby/multi_xml-0.5
	>=dev-ruby/rack-1.2"
ruby_add_bdepend "test? ( >=dev-ruby/rspec-2.5.0:2 )"

each_ruby_test() {
	CI=true ${RUBY} -S rspec spec || die
}
