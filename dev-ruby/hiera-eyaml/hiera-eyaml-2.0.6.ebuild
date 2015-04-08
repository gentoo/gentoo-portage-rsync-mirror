# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hiera-eyaml/hiera-eyaml-2.0.6.ebuild,v 1.2 2015/02/12 05:24:33 patrick Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md CHANGES.md PLUGINS.md"

inherit ruby-fakegem

DESCRIPTION="Encrypted YAML backend for hiera"
HOMEPAGE="https://github.com/TomPoulton/hiera-eyaml"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/highline"
ruby_add_rdepend "dev-ruby/trollop"
