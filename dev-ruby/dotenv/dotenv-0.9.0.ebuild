# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/dotenv/dotenv-0.9.0.ebuild,v 1.2 2014/05/26 05:35:58 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_EXTRADOC="README.md Changelog.md"
RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="Loads environment variables from .env into ENV"
HOMEPAGE="https://github.com/bkeepers/dotenv"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""
