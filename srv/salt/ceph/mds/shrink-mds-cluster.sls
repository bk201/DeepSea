{% set fs_name = salt['pillar.get']('fs_name') %}

{% if fs_name == "" %}

no file system name supplied:
  test.fail_without_changes:
    - name: |
        Please specify fs_name pillar var:
        salt <target> state.apply ceph.mds.restart.shrink-mds-cluster pillar='{"fs_name": "<name>"}'

{% else %}

set max_mds to 1:
  cmd.run:
    - name: ceph fs set {{ fs_name }} max_mds 1
    - failhard: True

{% endif %}
