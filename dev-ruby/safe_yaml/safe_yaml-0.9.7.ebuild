# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/safe_yaml/safe_yaml-0.9.7.ebuild,v 1.1 2013/09/17 15:53:46 mrueg Exp $

EAPI=5

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="Parse YAML safely, without that pesky arbitrary object deserialization vulnerability"
HOMEPAGE="https://dtao.github.com/safe_yaml"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/hashie
	dev-ruby/heredoc_unindent )"
