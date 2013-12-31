# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/github_api/github_api-0.10.2.ebuild,v 1.1 2013/12/25 13:08:09 graaff Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="A Ruby wrapper for the GitHub REST API v3"
HOMEPAGE="https://github.com/peter-murach/github"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "
	dev-ruby/addressable
	>=dev-ruby/faraday-0.8.7
	>=dev-ruby/hashie-1.2
	>=dev-ruby/multi_json-1.4:0
	>=dev-ruby/nokogiri-1.6.0
	dev-ruby/oauth2"

ruby_add_bdepend "
	test? ( dev-ruby/webmock )"
